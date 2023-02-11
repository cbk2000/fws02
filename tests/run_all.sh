current_dir=$(pwd)

if [[ $current_dir == *"tests"* ]]; then
  echo "Running from tests directory"
  cd ..
else
  echo "Not running from tests directory"
fi

cd pdir
bash p0_unzip.sh
bash p1_process.sh
bash p2.sh