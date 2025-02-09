echo "New image hash:"
echo $(docker images --no-trunc --quiet f-droid-repo:latest)

if [ ! -f ".image" ] || [ $(docker images --no-trunc --quiet f-droid-repo:latest) != $(cat .image) ]; then
  echo "update=true" >> $GITHUB_OUTPUT
fi

