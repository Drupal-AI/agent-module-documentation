# AWX / Ansible Tower Client — manual setup guide

**AWX / Ansible Tower Client** (`awx`) lets Drupal talk to an
[AWX](https://github.com/ansible/awx) or Ansible Tower automation server through
its REST API. In practice that means Drupal can launch Ansible **job templates**,
check their status, and otherwise drive infrastructure automation from inside the
site — bridging a content or admin action to an Ansible‑based operation.

Use it when you want an event in Drupal to kick off automation elsewhere: for
example provisioning tasks, deployments, or other DevOps workflows managed by
Ansible. It supports Drupal 10 and 11.

This is powerful and therefore sensitive. Launching Ansible jobs can **change real
infrastructure**, so treat the ability to trigger calls as a privileged action:
restrict who can configure and fire them, and keep the AWX API token secure. Note
the release is **1.0.0‑alpha3**, an early alpha — test it carefully before relying
on it.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

The AWX server endpoint (URL) and an API token are configured in the module's
settings, and then the module makes REST calls to launch and monitor jobs:

1. In AWX / Ansible Tower, create an API token for a user with permission to launch
   the job templates you want to trigger.
2. In Drupal, configure the AWX endpoint and the token in the module's settings.
3. Wire launching a job template to the Drupal action or event you want to trigger
   it from.

### Keep the API token secure

Store the token in an environment variable, not in committed configuration. With
DDEV:

```bash
ddev dotenv set .ddev/.env --awx-api-token=<value>
ddev restart
```

Keep `.ddev/.env` out of version control, and reference the `AWX_API_TOKEN`
variable through a Key entity or `getenv('AWX_API_TOKEN')`. Because a job launch
can change infrastructure, restrict who can configure the module and trigger calls.
