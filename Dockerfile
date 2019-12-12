FROM ruby:2.6.5

RUN apt-get update -qq && apt-get install -y build-essential postgresql-client

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for a JS runtime and Yarn
RUN curl -sL https://deb.nodesource.com/setup_13.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -qq -y build-essential libpq-dev nodejs yarn

ENV APP_HOME /one_bit_messenger
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD . $APP_HOME

RUN bundle install
ENTRYPOINT ["sh", "./entrypoint.sh"]

CMD ["rails", "server", "--binding", "0.0.0.0"]

# RUN apt-get update && apt-get install -y --no-install-recommends apt-utils