FROM php:8.1-fpm

ARG user=maycow
ARG uid=1000

# System dependencies
RUN apt update \
        && apt install -y \
            wget \
            netcat \
            g++ \
            git \
            libicu-dev \
            libpq-dev \
            libzip-dev \
            zip \
            zlib1g-dev \
        && docker-php-ext-install \
            intl \
            opcache \
            pdo \
            pdo_pgsql \
            pgsql

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install Symfony-CLI
RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | bash
RUN apt install -y symfony-cli

# Install NodeJS and enable YARN
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash
RUN apt install -y nodejs && corepack enable

# Install and configure ZSH
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.2/zsh-in-docker.sh)" -- \
    -t https://github.com/denysdovhan/spaceship-prompt \
    -a 'SPACESHIP_PROMPT_ADD_NEWLINE="false"' \
    -a 'SPACESHIP_PROMPT_SEPARATE_LINE="false"' \
    -p git \
    -p ssh-agent \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions

# Create a new super user
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

USER $user

# Configure Git
RUN git config --global user.email "melo.maycow@gmail.com" \ 
    && git config --global user.name "Maycow Marques" \
    && git config --global init.defaultBranch main

WORKDIR /var/www/app