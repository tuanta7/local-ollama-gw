install-brew:
	./install-brew.sh

install-dev-tools: install-brew
	brew install nvm

install-nginx: install-brew
	brew install nginx

run-nginx:
	sudo nginx

install-ollama:
	curl -fsSL https://ollama.com/install.sh | sh

run-ollama:
	ollama serve

MODEL ?= tinyllama
pull-model:
	ollama pull $(MODEL)

check-ollama:
	ps -ax | grep ollama

uninstall-ollama:
	sudo rm -rf /Applications/Ollama.app
	sudo rm /usr/local/bin/ollama
	rm -rf "~/Library/Application Support/Ollama"
	rm -rf "~/Library/Saved Application State/com.electron.ollama.savedState"
	rm -rf ~/Library/Caches/com.electron.ollama/
	rm -rf ~/Library/Caches/ollama
	rm -rf ~/Library/WebKit/com.electron.ollama
	rm -rf ~/.ollama

shutdown:
	sudo shutdown -h now