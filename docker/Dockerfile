# Elixir + Phoenix

FROM bitwalker/alpine-elixir:latest

RUN su -

# Install debian packages
RUN apk add curl 
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN apk update && apk upgrade && apk add --no-cache bash git openssh
RUN apk add --update krb5 krb5-libs gcc make g++ krb5-dev

# Install Phoenix packages
RUN mix local.hex --force
RUN mix local.rebar --force
RUN curl -o phx_new.ez https://github.com/phoenixframework/archives/raw/master/phx_new.ez

# Rust env
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUSTFLAGS="-C target-feature=-crt-static"
    
# Install Rust packages
RUN apk add rustup
RUN apk add build-base
RUN rustup-init -y

RUN chmod -R a+w $RUSTUP_HOME $CARGO_HOME

# Install node
RUN apk add nodejs
RUN apk add npm
RUN npm install pm2 -g
RUN npm install -g truffle

WORKDIR /app
EXPOSE 4000