# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.3.0
FROM ruby:$RUBY_VERSION-slim as base

# Rails app lives here
WORKDIR /app

# Set environment variables
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

# Install dependencies for building gems and runtime
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libvips pkg-config postgresql-client

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# Copy the rest of the application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Run as non-root user for security
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails /app
USER rails:rails

# Entrypoint prepares the database.
ENTRYPOINT ["./bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
