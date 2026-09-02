.PHONY: shutdown setup run

shutdown:
	sudo shutdown -h now

setup: install-dev-tools install-ollama install-nginx
	nvm version
	nginx -version
	ollama --version

run: run-ollama run-nginx
	brew services list

stop: stop-ollama stop-nginx
	brew services list

install-brew:
	./install-brew.sh

install-dev-tools: install-brew
	brew install nvm

install-ollama:
	brew install ollama

run-ollama:
	brew services start ollama

stop-ollama:
	brew services stop ollama

run-ollama-serve:
	ollama serve

MODEL ?= llama3.2:1b
pull-model:
	ollama pull $(MODEL)

test-ollama:
	curl -w "Time: %{time_total}s\n" http://localhost:11434/api/generate -d '{ \
		"model": "$(MODEL)", \
		"prompt": "Rewrite the given sentence in a casual, natural tone. Provide exactly 3 variants in JSON array format and output only the rewritten sentences, with no explanations, labels, or additional text: Hey, are you free for a quick call? ", \
		"stream": false, \
		"options": { \
			"num_predict": 1000, \
			"temperature": 0.2, \
			"top_p": 0.6, \
			"top_k": 20 \
		} \
	}'

uninstall-ollama:
	brew uninstall ollama
	sudo rm -rf /Applications/Ollama.app
	sudo rm /usr/local/bin/ollama
	rm -rf "~/Library/Application Support/Ollama"
	rm -rf "~/Library/Saved Application State/com.electron.ollama.savedState"
	rm -rf ~/Library/Caches/com.electron.ollama/
	rm -rf ~/Library/Caches/ollama
	rm -rf ~/Library/WebKit/com.electron.ollama
	rm -rf ~/.ollama

install-nginx: install-brew
	brew install nginx

run-nginx:
	touch /opt/homebrew/etc/nginx/servers/ollama.conf
	cp ./nginx/ollama.conf /opt/homebrew/etc/nginx/servers/ollama.conf
	brew services start nginx

stop-nginx:
	brew services stop nginx

install-cloudflared:
	brew install cloudflared