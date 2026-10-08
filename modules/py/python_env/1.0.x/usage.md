<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Python Environment provides a PHP→Python bridge to run pre-placed Python scripts.

---

Python Environment (python_env) provides a bridge service to run Python scripts from PHP — a `PythonBridge` service invokes `python3` on scripts placed in a root-level `/python/` directory, passing input as a JSON argument. It lets developers offload logic (ML, data processing) to Python from Drupal.

Execution passes the script path and JSON input as process arguments (argv, not a shell string), so there is no shell-injection surface; the trust boundary is who can place scripts in `/python/` and who calls the bridge — treat it as a privileged developer tool (like PHP/scripting features) and keep the scripts directory deploy-controlled. Depends on core `system`; requires Drupal 11.

---

- Run Python scripts from PHP.
- Provide a PythonBridge service.
- Invoke `python3` on scripts.
- Read scripts from a root `/python/` dir.
- Pass input as a JSON argv (no shell).
- Offload logic to Python.
- Have no shell-injection surface.
- Treat as a privileged developer tool.
- Keep the scripts dir deploy-controlled.
- Depend on core `system`.
- Require Drupal 11.
- Support ML/data processing.
- Bridge Drupal and Python
- Call scripts safely
- Restrict who places scripts.
- Run offloaded logic.
- Support developers.
- Execute Python
