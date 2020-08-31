include ../../../../../Makefile

define HELP

endef
export HELP

CLI_INPUT_JSON="file://./postgres/cli.json"
KEY_ID="alias/ryan-rds-postgres-grafana"
MASTER_PASSWORD_KEY="postgres/master_password"
ROLE_PASSWORD_KEY="postgres/role_password"
OUTPUT=text
PASSWORD ?= $(shell bash -c 'read -s -p "Password: " pwd; echo $$pwd')

encrypt:
	aws kms encrypt \
		--key-id "${KEY_ID}" \
		--cli-input-json "${CLI_INPUT_JSON}" \
		--plaintext fileb://${MASTER_PASSWORD_KEY}.txt \
		--output "${OUTPUT}" \
		--query CiphertextBlob > ${MASTER_PASSWORD_KEY}.base64
	cat ${MASTER_PASSWORD_KEY}.base64 |  base64  --decode > ${MASTER_PASSWORD_KEY}
	aws kms encrypt \
		--key-id "${KEY_ID}" \
		--cli-input-json "${CLI_INPUT_JSON}" \
		--plaintext fileb://${ROLE_PASSWORD_KEY}.txt \
		--output "${OUTPUT}" \
		--query CiphertextBlob > ${ROLE_PASSWORD_KEY}.base64
	cat ${ROLE_PASSWORD_KEY}.base64 | base64 --decode > ${ROLE_PASSWORD_KEY}
check_encrypt:
	@aws kms decrypt \
		--cli-input-json "${CLI_INPUT_JSON}" \
		--ciphertext-blob fileb://${MASTER_PASSWORD_KEY} \
		--output "${OUTPUT}" \
		--query Plaintext \
	| base64 --decode \
	| diff ./${MASTER_PASSWORD_KEY}.txt - > /dev/null \
	&& echo "\033[32mThe master passwords match!\033[0m" \
	|| echo "\033[31mThe master passwords are different.\033[0m"
	@aws kms decrypt \
		--cli-input-json "${CLI_INPUT_JSON}" \
		--ciphertext-blob fileb://${ROLE_PASSWORD_KEY} \
		--output "${OUTPUT}" \
		--query Plaintext \
	| base64 --decode \
	| diff ./${ROLE_PASSWORD_KEY}.txt - > /dev/null \
	&& echo "\033[32mThe role passwords match!\033[0m" \
	|| echo "\033[31mThe role passwords are different.\033[0m"
