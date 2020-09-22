NAME = Workshop Scaffolding

########
# HUGO #
########


# Clean out static assets from prod build
clean:
	rm -rf workshop/public/*

#http://localhost:1313/ps-eks-accelerator/
dev: ## Run in development mode
	cd workshop && hugo serve -D

package:
	cd workshop && hugo -t learn -d public --gc --minify --cleanDestinationDir

build: package dev


## WIP for amplify deployment using custom URL scheme

amplify:
	cd hugo-cdk-deployment/ 
	npm install -g aws-cdk
	npm install
	npm run build

domain:
	aws route53 create-hosted-zone --name workshop.com --caller-reference 2014-04-01-18:47 --hosted-zone-config Comment="command-line version"

cdK:
	cd hugo-cdk-deployment && \
	cdk synth \
		--context domain=modernization-solutions.proserve.aws.dev \
		--context hostname=Workshop \
		--context offering=BasicExample