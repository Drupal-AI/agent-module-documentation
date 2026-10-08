# Configuration

There are two pages to know: a **settings** page where you choose the AI provider
and model, and the **generator** page where you actually describe and build content
types. You configure the first, then use the second.

## 1. Settings — choose the provider and model

1. Log in as a user with the **Administer AI content type generator** permission
   (restricted).
2. Go to **Configuration → AI → Content Type Generator**, or navigate directly to
   `/admin/config/ai/content-type-generator`.

Here you pick which of AI Core's configured **providers** and **models** the
generator should use (for example an OpenAI or Anthropic chat model) and set the
generation options. The module stores no API key of its own — it uses whatever
provider AI Core has set up, so make sure AI Core has a working provider before you
generate anything.

## 2. Generate a content type

1. As a user with the **Generate AI content types** permission, go to **Structure →
   Content types → AI generator**, or navigate to
   `/admin/structure/types/ai-generator`.
2. **Describe the content type in plain English** — for example, "an Event content
   type with a summary, a date, a venue, and a category reference."
3. The module sends the prompt to the configured provider, **validates the returned
   JSON** definition, and then builds and saves the content type together with its
   fields and matching form-display and view-display components.

Because each generation is a **billed provider call**, keep the *Generate AI
content types* permission with trusted site builders only.

## 3. Update an existing content type

From the same generator, describe a change to an existing type — for example, "add
a Registration Link field and remove the Organizer field." The module applies the
change in place. **In-place updates additionally require core's *Administer content
types* permission**, because you are editing existing structure, not just creating
new.

## Which field types you can generate

The generator can produce a field type only if the core module that provides it is
enabled. Enable the ones you need before generating:

| Field type | Requires core module |
|------------|----------------------|
| Date / time | `datetime` |
| Telephone | `telephone` |
| Link | `link` |
| File | `file` |
| Image | `image` |
| Options (list) | `list_string` (Options) |
| Comment | a comment field (Comment module) |

If a described field maps to a module you have not enabled, that field type simply
won't be available — enable the module and regenerate.

## Tips

- Start from a clear, specific description; the more precisely you describe fields
  and their purpose, the closer the generated model will be.
- Review the generated content type and its fields before using it in production —
  the definition comes from an AI model and is validated for structure, not for
  editorial judgement.
- Iterate conversationally: generate a first version, then describe adjustments to
  refine it.
