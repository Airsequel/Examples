.PHONY: help
help: makefile
	@tail -n +4 makefile | grep ".PHONY"


.INTERMEDIATE: spago-bundle.js
spago-bundle.js: $(wildcard src/**/*.purs)
	npx spago bundle \
		--platform node \
    --bundle-type module \
		--minify \
		--outfile $@


# Clean up the bundle as described in readme.md
index.js: spago-bundle.js
	cat $< \
	| sed -E \
			-e "s/from 'module'/from 'node:module'/g" \
			-e "s/from 'path'/from 'node:path'/g" \
			-e "s/from 'url'/from 'node:url'/g" \
			\
			-e 's/const require.+;//g' \
			-e 's/const __dirname.+;//g' \
			-e 's/const __filename.+(;|pathname)//g' \
			\
			-e 's/export{(.*) as main}/\
						export default async function main (context) { \
							return \1(context)() \
						}/g' \
	> $@


.PHONY: bundle
bundle: index.js


.PHONY: test
test: $(wildcard src/**/*.purs) $(wildcard test/**/*.purs)
	npx spago test
