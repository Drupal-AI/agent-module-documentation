# AI Agents Debugger — manual setup guide

**AI Agents Debugger** (`ai_agents_debugger`) is a developer tool for looking
inside what your AI agents are doing. When an agent runs, it takes a series of
steps — reasoning ("thoughts"), calling tools, and producing responses — and
normally that all happens out of sight. This module surfaces that activity so you
can watch and troubleshoot an agent's behaviour while you build it.

It depends on the **AI Agents** module and adds no agent capabilities of its own;
it simply monitors and displays the actions, intermediate thoughts, tool calls
and responses of the agents you already have. When an agent does something
unexpected, the debugger is where you go to see why.

**Handle it carefully.** Agent traces can contain **sensitive data** — the prompts
sent, the inputs and outputs of tools, retrieved content, and potentially
credentials passed to tools. For that reason, restrict the module's permission to
**trusted developers only**, and prefer **not to enable it on production** (or at
least strictly limit who can view traces there).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The debugger exposes agent traces behind its own permission. Grant that permission
only to the developers who need it, then trigger an agent and inspect the recorded
actions, thoughts, tool calls and responses to understand what happened.

## How to use it

1. Enable the module in a development environment.
2. Grant the debug/view permission to your developer role.
3. Run an AI agent and open the debugger view to trace its steps. Use what you see
   to diagnose prompt, tool, or routing problems, then disable the module (or lock
   the permission down) before going to production.
