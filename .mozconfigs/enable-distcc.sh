# Note if not using ccache your mozconfig needs additional tweaking, see below
export CCACHE_PREFIX=distcc

# --randomize means spread jobs out evenly over hosts.
DISTCC_HOSTS="--randomize bangles.mv.mozilla.com/16 gandalf.mv.mozilla.com/16"

# Also use localhost. We limit slots to six because the localhost also needs to
# do all the pre-processing, so if it is overloaded it wont be able to send out jobs fast enough
#DISTCC_HOSTS="$DISTCC_HOSTS localhost/6 --localslots=6 --localslots_cpp=10"
# Alternately: Don't use localhost at all except for preprocessing (do as much
# work as possible on other machines)
DISTCC_HOSTS="$DISTCC_HOSTS --localslots_cpp=8"

export DISTCC_HOSTS
# Retry aggressively when no machines are available (default is 1000)
export DISTCC_PAUSE_TIME_MSEC=10
# If a compile fails, distcc defaults to just ignoring that machine for the rest
# of the compile. Instead, make it actually print an error.
export DISTCC_BACKOFF_PERIOD=0
export DISTCC_FALLBACK=1
export DISTCC_SKIP_LOCAL_RETRY=1

# This is exported for the mozconfig to use. |distcc -j| looks at the vars we
# just set and determines how many distcc jobs can run at once.
export MAKE_JOBS=$(( $(distcc -j) * 2 ))
echo ":: distcc configured with $MAKE_JOBS jobs"
