# drush — commands AI Core adds

## `ai:chat` (aliases: `chat`, `ai`)

Send a message to the site's **default chat provider/model** and print the response. Handy
for verifying a provider is configured and reachable without touching the UI.

```bash
# One-shot: prints the model's reply.
drush ai:chat "Hello, how are you?"

# Interactive mode: type your message, then Ctrl+D (EOF) to send.
drush ai

# Override the configured defaults for this call.
drush ai:chat "Summarize Drupal in one line." \
  --provider=openai \
  --model=gpt-4o \
  --system="You are a terse assistant."
```

| Argument / option | Meaning |
|---|---|
| `input` (argument) | the message to send; omit to enter interactive mode |
| `--provider` | provider id to use instead of the default |
| `--model` | model id to use instead of the default |
| `--system` | system message to use instead of the default |

If no default chat provider/model is configured and none is passed, the command errors with
"No default AI provider or model set" — configure one at `/admin/config/ai/settings` (see
[configure/ai.md](../configure/ai.md)). Requires at least one enabled provider module.
