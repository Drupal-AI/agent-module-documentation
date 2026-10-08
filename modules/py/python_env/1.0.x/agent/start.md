<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Python Environment — agent index

**PHP→Python bridge** to run scripts from `/python/`. Version **1.0.1**. Core `^11`.

Runs `python3 script inputJson` via argv (no shell injection); trust boundary = who places scripts / calls the bridge — privileged developer tool, keep scripts dir deploy-controlled. Depends on core `system`.