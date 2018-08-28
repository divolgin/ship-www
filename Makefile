.PHONY: install build build_staging serve serve_staging index-site index-and-send index-and-send-staging

install:
	yarn

build:
	yarn gulp
	hugo -v

build_staging:
	yarn gulp
	hugo -v --config config.staging.yaml

serve:
	hugo serve

serve_staging:
	hugo serve --config config.staging.yaml

index-site:
	yarn index-site

index-and-send:
	yarn index-and-send

index-and-send-staging:
	yarn index-and-send-staging

