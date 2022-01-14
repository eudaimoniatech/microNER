# Sets up the folders needed to run the docker-compose setup.
# Prerequisites:
# 1. git
# 2. docker
# 3. 10GB RAM available
# 4. AVX CPU

git clone --recurse-submodules https://github.com/eudaimoniatech/microNER.git
cd microNER
chmod 777 -R embeddings

echo "--------------------------------------------------"
echo "--------------------------------------------------"
echo "--------------------------------------------------"
echo "Setup finished. You can now start the application."
echo "--------------------------------------------------"
echo "--------------------------------------------------"
echo "--------------------------------------------------"