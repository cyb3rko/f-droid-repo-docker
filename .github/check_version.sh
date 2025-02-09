old_hash=$(cat .image)
new_hash=$(docker images --no-trunc --quiet $REGISTRY/$IMAGE_NAME:latest)
echo "Previous image hash:"
echo $old_hash
echo "New image hash:"
echo $new_hash

if [ ! -f ".image" ] || [ $new_hash != $old_hash ]; then
  echo "New image found, requesting image push to registry"
  echo "update=true" >> $GITHUB_OUTPUT
else
  echo "Image has not changed, no image push to registry required"
fi

