set -x
valid_branch_regex="
^(feature|bugfix|release|scratch)\/[a-z0-9._-]+$
^develop+$
^main+$
^integration\/develop+$
"

local_branch="$(git rev-parse --abbrev-ref HEAD)"

message="There is something wrong with your branch name. Branch names in this project must adhere to use any of these patterns.feature/*,bugfix/*,scratch/*,release/*,develop,main,integration/develop. Your branch creation will be rejected and deleted. You should rename your branch to a valid name and try again."

for branch_regex in ${valid_branch_regex}; do
        if [[  $local_branch =~ $branch_regex ]]
        then
                exit 0
        fi
done
echo "$message"
git push origin :$local_branch
exit 1

