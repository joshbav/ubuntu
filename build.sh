docker build --squash -t joshbav/ubuntu:latest .
echo
echo
echo
echo Pushing newly built image to dockerhub
echo
docker push joshbav/ubuntu:latest
