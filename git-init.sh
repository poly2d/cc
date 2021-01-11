#!/bin/bash

# This script sets up a pre-commit hook to ensure that vault.yaml is encrypted,
# and all vault changes are checked in. Not ideal as it assumes commands are
# run in comment-server dir, but better than no check.
#
# referenced:
# - https://gitlab.com/NickBusey/HomelabOS/-/issues/355
# - https://github.com/IronicBadger/compose-secret-mgt

HOOKS_DIR=".git/hooks"
PRECOMMIT_PATH="${HOOKS_DIR}/pre-commit"

VAULT_PATH="vars/vault.yaml"
VAULT_WORKTREE="comment-server"

if [ -d .git/ ]; then

mkdir -p $HOOKS_DIR
rm $PRECOMMIT_PATH
cat <<EOT >> $PRECOMMIT_PATH

echo pre-commit hook

# Check branch to see if the pwd is in the comment-server worktree
if ( git rev-parse --abbrev-ref HEAD | grep -q "${VAULT_WORKTREE}" ); then
  echo "[38;5;208mSkipping Vault check.[0m"
  exit 0
fi

# Check if vault file is encrypted.
if ( cat ${VAULT_PATH} | grep -q "\$ANSIBLE_VAULT;" ); then
  echo "[38;5;208mVault not encrypted! Encrypt and try again.[0m"
  exit 1
fi
echo "[38;5;108mVault is encrypted.[0m"

# Check if there are unstaged changes on the vault file
if ( git diff --name-only | grep -q "${VAULT_PATH}" ); then
  echo "[38;5;208mUnstaged changes to Vault! Add changes and try again.[0m"
  exit 1
fi
echo "[38;5;108mNo unstaged changes to Vault.[0m"

echo "[38;5;108mSafe to commit.[0m"
EOT

chmod +x $PRECOMMIT_PATH
fi
