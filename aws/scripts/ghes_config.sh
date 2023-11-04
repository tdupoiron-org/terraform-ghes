  #!/bin/bash

  # Variables (replace with actual values)
  GHES_ADMIN_PASSWORD="AdminGitHub1234"
  GHES_HOSTNAME="ghes.dupoiron.com"
  SSH_PRIVATE_KEY_PATH="~/.ssh/id_rsa"
  SSH_USER="admin"
  SSH_HOST="15.236.226.0"
  SSH_PORT=122

  # SSH command
  SSH_COMMAND="ssh -i $SSH_PRIVATE_KEY_PATH -p $SSH_PORT $SSH_USER@$SSH_HOST"

  # Execute commands
  $SSH_COMMAND "ghe-config core.admin-password $GHES_ADMIN_PASSWORD"
  $SSH_COMMAND "ghe-config core.github-hostname $GHES_HOSTNAME"
  $SSH_COMMAND "ghe-ssl-acme -e"
  $SSH_COMMAND "ghe-config-apply"