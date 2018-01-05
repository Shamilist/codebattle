FROM elixir

WORKDIR /app

# Install hex (Elixir package manager)
RUN mix local.hex --force

# RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

# Install rebar (Erlang build tool)
RUN mix local.rebar --force

RUN apt-get update && apt-get install -y inotify-tools

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update && apt-get install -y nodejs

RUN curl -s --show-error https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y  yarn

ENV DOCKER_CHANNEL edge
ENV DOCKER_VERSION 17.11.0-ce
RUN curl -fsSL "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" \
  | tar -xzC /usr/local/bin --strip=1 docker/docker

RUN  apt-get -qq purge --assume-yes --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps
RUN  apt-get clean
RUN  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy all dependencies files
COPY mix.* ./

# Install all production dependencies
RUN mix deps.get

RUN  mkdir -p assets
COPY assets/package.json ./assets
COPY assets/yarn.lock ./assets

RUN cd assets/ && yarn install && cd ../

# Compile all dependencies
RUN mix deps.compile

COPY . .

RUN NODE_ENV=production cd assets/ && yarn deploy && cd ../
# RUN MIX_ENV=prod mix compile
# RUN MIX_ENV=prod mix phx.digest

CMD ["mix", "phx.server"]
