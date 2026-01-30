PX4_DIR=~/code/px4
PX4_DEFAULT_FMU_VARIANT=v5x
PX4_DEFAULT_SITL_VARIANT=quad_x
PX4_DOCKER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

alias cdpx='cd $PX4_DIR'

mpx() {
	if [[ "${1-}" == --help ]] || [[ $# -eq 0 ]]; then
		cat <<-'EOF'
		Usage: mpx <type> [variant]
		  type     Whether to build Nuttx targets ('fmu') or SITL ('gz', 'newton', etc.)
		  variant  Build variant for NuttX target (default: 'v5x'), or model for SITL (default: 'default')
		Examples: mpx newton           → make px4_sitl newton_default
		          mpx newton astro     → make px4_sitl newton_astro
		          mpx gz x500_default  → make px4_sitl gz_x500_default
		          mpx fmu              → make px4_fmu-v5x
		          mpx fmu v3_altaxv1   → make px4_fmu-v3_altaxv1
		EOF
		return
	fi
	local type="$1"
	local variant="${2-}"

	local container make_target build_dir
	if [[ "$type" == fmu ]]; then
		container="px4-fmu"
		variant="${variant:-$PX4_DEFAULT_FMU_VARIANT}"
		make_target="px4_fmu-$variant"
		build_dir="$PX4_DIR/build/$make_target"
	else
		container="px4-sitl-$type"
		variant="${variant:-$PX4_DEFAULT_SITL_VARIANT}"
		make_target="px4_sitl ${type}_$variant"
		build_dir="$PX4_DIR/build/px4_sitl_default"
	fi

	cd "$PX4_DOCKER_DIR" && docker compose up "$container" -d && docker exec -it "$container" make $make_target
	cp "$build_dir/compile_commands.json" "$PX4_DIR/"
}

mavtcp() {
	if ! command -v mavp2p > /dev/null; then
		echo "mavp2p not found"
		return 1
	fi
	mavp2p udps:0.0.0.0:14550 tcps:0.0.0.0:5760 > /dev/null 2>&1 &
	echo "MAVLink router started"
}
