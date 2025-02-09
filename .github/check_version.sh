hash=$(docker images --no-trunc --quiet $REGISTRY/$IMAGE_NAME:latest)
echo "New image hash:"
echo $hash

if [ ! -f ".image" ] || [ $hash != $(cat .image) ]; then
  echo "update=true" >> $GITHUB_OUTPUT
fi

