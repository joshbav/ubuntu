docker build --squash -t joshbav/ubuntu:latest .
echo
echo
echo
echo Pushing newly built image to dockerhub
echo
docker push joshbav/ubuntu:latest

git config user.name “joshbav”
git add -A
git commit -m "Scripted commit $(date +%d-%b-%Y-%I:%M:%S%p)"
git push -u origin master

