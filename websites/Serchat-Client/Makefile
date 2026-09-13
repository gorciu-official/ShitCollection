frontend: register_hooks
	python3 -m http.server 5173

backend: register_hooks
	node peak.mjs

register_hooks:
	chmod +x scripts/git/pre-commit
	git config core.hooksPath scripts/git