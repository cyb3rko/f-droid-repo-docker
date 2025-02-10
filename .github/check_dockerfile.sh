old_hash=$(cat Dockerfile.sha256)
new_hash=$(sha256sum Dockerfile | cut -d' ' -f1)
echo "Last processed Dockerfile hash:"
echo $old_hash
echo "Current Dockerfile hash:"
echo $new_hash

if [ $new_hash != $old_hash ]; then
  echo "New Dockerfile found, requesting image push to registry (tag: latest)"
  echo "update=true" >> $GITHUB_OUTPUT
else
  echo "Dockerfile has not changed, no image push to registry required"
fi

