#! /bin/bash
# this called a shebang, which is to declare what shell is going to run this script; shebang dictates what shell runs the script. We use sh shell to run scripts since they are more efficient.

repoName=$1    # declare a variable called repoName and assign it the value of first parameter the script receives
githubToken=$3
githubUsername=$2

while [ -z "$repoName" ]   #While repoName variable is unassigned...
do
   echo 'Provide a repository name'     #Write this message
   read -r -p $'Repository name:' repoName     #read whatver input provided and assign to repoName variable; -r prevents backslashes from being interpreted as escape characters; -p allows prompt
done

while [ -z "$githubUsername" ]   #While repoName variable is unassigned...
do
   echo 'Provide a Git Hub Username'     #Write this message
   read -r -p $'Git Hub Username:' githubUsername     #read whatver input provided and assign to repoName variable; -r prevents backslashes from being interpreted as escape characters; -p allows prompt
done

while [ -z "$githubToken" ]   #While repoName variable is unassigned...
do
   echo 'Provide Git Hub Token:'     #Write this message
   read -r -p $'Git Hub Token:' githubToken     #read whatver input provided and assign to repoName variable; -r prevents backslashes from being interpreted as escape characters; -p allows prompt
done

echo "# $repoName" >> README.md    # create a readme file and create a single line with repos name
git init                          # initialize git repo
git add .                         # addes change to the working directory to the staging area
git commit -m "First Commit"      # make first commit

curl -u "$githubUsername:$githubToken" \
   -X POST https://api.github.com/user/repos \
   -H "Content-Type: application/json" \
   -d "{\"name\": \"$repoName\", \"private\": false}" \

GIT_URL=$(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/biznesskim/"$repoName" | jq -r '.clone_url')  # need remote URL of new repo; declare GIT_URL and assign what returns

git branch -M main                  # rename our master branch to main
git remote add origin $GIT_URL      # add the remote origin we just obtained
git push -u origin main             # push our code to GitHub









