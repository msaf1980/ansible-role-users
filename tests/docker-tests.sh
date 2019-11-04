#! /usr/bin/env bash
#
# Author: Bert Van Vreckem <bert.vanvreckem@gmail.com>
#
# Usage: DISTRIBUTION=<distro> VERSION=<version> ./docker-tests.sh
#
# Creates a Docker container for the specified Linux distribution and version,
# available at https://hub.docker.com/r/bertvv/ansible-testing/; runs a syntax
# check; applies this role to the container using a test playbook; and,
# finally, runs an idempotence test.
#
# Environment variables DISTRIBUTION and VERSION must be set outside of the
# script.
#
# EXAMPLES
#
# $ DISTRIBUTION=centos VERSION=7 ROLE=msaf1980.squid ./tests/docker-tests.sh
# $ DISTRIBUTION=debian VERSION=9 ROLE=msaf1980.squid ./tests/docker-tests.sh
# $ DISTRIBUTION=ubuntu VERSION=18.04 ROLE=msaf1980.squid ./tests/docker-tests.sh
#

readonly script_dir=$( dirname "${BASH_SOURCE[0]}" )

. ${script_dir}/docker-tools || exit 1

start_container || exit 1
main_file="${id_file}"
main_id="${id}"

run_syntax_check ${main_id} ${role_dir}/${test_playbook}
run_test_playbook ${main_id} ${role_dir}/${test_playbook}
run_idempotence_test ${main_id} ${role_dir}/${test_playbook}

exec_container ${main_id} ${role_dir}/tests/functional-tests.sh || exit 1

cleanup_container ${main_file}
