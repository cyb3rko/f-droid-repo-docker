old_tag=$(cat .tag)
new_tag=$TAG
echo "Last processed tag:"
echo $old_tag
echo "Current fdroidserver tag:"
echo $new_tag

if [ $new_tag != $old_tag ]; then
  echo "New fdroidserver tag '${new_tag}' found, requesting image push to registry (tags: latest, ${new_tag})"
  echo "update=true" >> $GITHUB_OUTPUT
else
  echo "Tag has not changed, no image push to registry required"
fi

