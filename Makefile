SHELL=/bin/bash
MUSTACHE=node_modules/.bin/mustache
BUILD=build
VARIABLES=Revenue Contributors Streak Stability
VARIANTS=$(foreach variable,$(VARIABLES),$(addprefix Mortarboard-,$(addsuffix .md,$(variable))))

all: $(addprefix $(BUILD)/,$(VARIANTS))

$(BUILD)/%.md: %.json LICENSE.md | $(BUILD) $(MUSTACHE)
	$(MUSTACHE) $*.json LICENSE.md | fmt -w60 -u > $@

%.json:
	echo '{"$*": true}' > $@

$(BUILD):
	mkdir -p $@

$(MUSTACHE):
	npm install

.PHONY: clean

clean:
	rm -rf $(BUILD)
