# 사용할 Ruby 이미지 선택
FROM ruby:3.2.2

# 필요한 패키지 설치
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# 작업 디렉토리 설정
WORKDIR /app

COPY jekyll-theme-chirpy.gemspec ./
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

COPY . .

# Jekyll 설치
RUN gem install jekyll

# 포트 설정
EXPOSE 4000

ENV JEKYLL_FORCE_POLLING=true

# 컨테이너 시작 시 실행할 명령어
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--watch"]

