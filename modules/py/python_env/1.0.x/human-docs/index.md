# Python Environment — manual setup guide

**Python Environment** (`python_env`) lets your Drupal code run **Python scripts**
from PHP. It provides a simple bridge service: you place your Python scripts in a
`/python/` directory at the root of the project, then call the bridge from PHP with
a script name and arguments. Input and output are exchanged as **JSON**, which keeps
the boundary between your Drupal (PHP) logic and your Python logic clean and easy to
work with.

It is aimed at cases where Python is the better tool for a job — data processing,
automation, calling a machine-learning model, or custom logic you already have in
Python — while keeping the two codebases separate. When you enable the module it
automatically creates the `/python/` folder if it does not already exist, and there
is nothing else to configure: place your scripts there and call the service.

> **This is a privileged developer tool — treat it accordingly.** Running Python
> from PHP means whoever can place scripts in `/python/` (or trigger the bridge)
> can execute code on your server. The module passes the script path and JSON input
> as separate process arguments (argv), not as a shell string, so there is no
> shell-injection surface — but the trust boundary is *who controls the scripts
> directory and who calls the bridge*. Keep `/python/` **deploy-controlled** (part
> of your reviewed, version-controlled deployment), never writable from the web or
> populated from user input, exactly as you would treat any code-execution feature.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm Python is available on the server.

There is **no configuration page** for this module — no further configuration is
required beyond placing scripts in `/python/`.

## How to use it

1. Put your Python script (for example `myscript.py`) in the `/python/` directory
   the module created at the project root.
2. From PHP, call the `python_env.bridge` service with the script name and any
   arguments; the script receives its input as a JSON argument and returns JSON
   output.
3. Drupal reads the JSON result and works with it as normal PHP data.
