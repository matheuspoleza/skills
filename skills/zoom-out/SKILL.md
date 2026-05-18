---
name: zoom-out
description: Go up one layer of abstraction from the current code or file and map the modules around it plus who calls into them. Use when stuck in details, asked to "zoom out", "show me the bigger picture", "where does this fit", or "what calls this".
---

# Zoom Out

Step up one abstraction layer. From the current file/function/concern, map:

1. **What module does this belong to** (its directory and stated purpose)
2. **What other modules sit at the same level** (siblings — list them with one-line each)
3. **Who calls into this module** (grep imports/usages, list top callers)
4. **Who this module depends on** (top imports)

Show the map as a small ASCII diagram or bullet tree. End with one sentence: *"This sits {where} in the architecture and is used for {what}."*

If asked to zoom out again, repeat from the parent module.

---

## NOT

- Does not refactor
- Does not propose changes
- Does not write to disk — output is for the current conversation only
