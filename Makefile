SHELL=/bin/bash
MUSTACHE=node_modules/.bin/mustache
TEMPLATE=LICENSE.mustache.md
BUILD=build
VARIABLES=Revenue Contributors Streak Stability
VARIANTS=$(foreach variable,$(VARIABLES),$(addprefix Mortarboard-,$(addsuffix .md,$(variable))))

all: $(addprefix $(BUILD)/,$(VARIANTS))

$(BUILD)/%.md: %.json $(TEMPLATE) | $(BUILD) $(MUSTACHE)
	$(MUSTACHE) $*.json $(TEMPLATE) | fmt -w60 -u > $@

%.json:
	echo '{"$*": true}' > $@

$(BUILD):
	mkdir -p $@

$(MUSTACHE):
	npm install

.PHONY: clean

clean:
	rm -rf $(BUILD)
