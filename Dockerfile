FROM php:8.1-fpm

ARG user=maycow
ARG uid=1000

# System dependencies
RUN apt update \
        && apt install -y \
            zsh \
            zsh-syntax-highlighting \
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

# Create a new super user
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

USER $user

# Configure Git
RUN git config --global user.email "melo.maycow@gmail.com" \ 
    && git config --global user.name "Maycow Marques" \
    && git config --global init.defaultBranch main

RUN sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" \
    && git clone https://github.com/spaceship-prompt/spaceship-prompt.git "/home/maycow/.oh-my-zsh/custom/themes/spaceship-prompt" --depth=1 \
    && git clone https://github.com/zsh-users/zsh-autosuggestions "/home/maycow/.oh-my-zsh/custom/plugins/zsh-autosuggestions" \
    && ln -s "/home/maycow/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "/home/maycow/.oh-my-zsh/custom/themes/spaceship.zsh-theme"

WORKDIR /var/www/app