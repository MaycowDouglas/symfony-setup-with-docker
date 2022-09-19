# symfony with docker

## Get started

```bash
project_name="api" &&
mkdir $project_name $project_name/.devcontainer &&
wget -P ./$project_name https://github.com/MaycowDouglas/symfony-setup-with-docker/raw/main/start.sh &&
wget -P ./$project_name https://github.com/MaycowDouglas/symfony-setup-with-docker/raw/main/nginx.conf &&
wget -P ./$project_name https://github.com/MaycowDouglas/symfony-setup-with-docker/raw/main/docker-compose.yaml &&
wget -P ./$project_name https://github.com/MaycowDouglas/symfony-setup-with-docker/raw/main/composer.json &&
wget -P ./$project_name https://github.com/MaycowDouglas/symfony-setup-with-docker/raw/main/Dockerfile &&
wget -P ./$project_name https://github.com/MaycowDouglas/symfony-setup-with-docker/raw/main/.zshrc &&
wget -P ./$project_name/.devcontainer https://github.com/MaycowDouglas/symfony-setup-with-docker/raw/main/.devcontainer/devcontainer.json &&
wget -P ./$project_name/.devcontainer https://github.com/MaycowDouglas/symfony-setup-with-docker/raw/main/.devcontainer/docker-compose.yml
```
