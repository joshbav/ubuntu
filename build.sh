docker build --squash -t joshbav/ubuntu:latest .
echo
echo
echo
echo Pushing newly built image to dockerhub
echo
docker push joshbav/ubuntu:latest

echo
echo
echo Adding all files in repo and pushing to git
git config user.name “joshbav” --local
git config user.email "joshbav@users.noreply.github.com" --local
git add -A
git commit -m "Scripted commit $(date +%d-%b-%Y-%I:%M:%S%p)"
git push -u origin master

