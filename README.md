# URL Feedback Agent Demo

A lightweight `n8n` demo that accepts a **URL** and a **Prompt**, scrapes the webpage content, and returns tailored AI feedback locally at `http://localhost:5678`.

---

## Overview

This demo is designed for presentation use:

1. A user opens the local `n8n` form
2. Enters a webpage **URL**
3. Enters a custom analysis **Prompt**
4. The workflow fetches the page content
5. The AI returns a tailored response based on the scraped text

---

## Current Demo Flow

```text
On form submission
→ HTTP Request
→ Code (clean HTML into readable text)
→ OpenAI Chat Model / AI step
→ Respond to Form
```

### Node roles

- **On form submission**: collects `URL` and `Prompt`
- **HTTP Request**: fetches the HTML of the submitted page
- **Code**: removes HTML noise and produces `scrapedText`
- **OpenAI Chat Model / AI step**: analyzes the scraped content using the prompt
- **Respond to Form**: displays the final answer back in the browser

---

## Local Access

Once the container is running, the `n8n` editor is available at:

```text
http://localhost:5678
```

---

## Example Demo Input

### URL
```text
https://www.bbc.com/news/live/cm29zmpdj3vt
```

### Prompt
```text
Analyze this BBC live news page for a classroom demo. Provide: (1) a 3-bullet summary of the main developments, (2) the likely audience and tone, (3) why the page is effective or ineffective as a live news article, and (4) 3 actionable suggestions to improve clarity, trust, and readability.
```

---

## Running the Container

From the repo root:

```powershell
docker compose up -d --build
```

To stop it:

```powershell
docker compose down
```

---

## Notes / Troubleshooting

### If the form submits but no response appears
- Make sure a **Respond to Form** node is connected at the end of the flow.

### If the agent asks for the URL again
- The scraped page text is likely not being passed into the AI step.
- Ensure the flow is linear:
  - `Form → HTTP Request → Code → AI → Respond to Form`

### If a memory/session error appears
- Remove memory from the demo flow unless using a proper chat session trigger.

### If the page fetches but content is messy
- Use the `Code` node to clean HTML before sending it to the model.

---

## Presentation Angle

This demo shows how an AI workflow can:

- take live user input
- retrieve real web content dynamically
- combine scraping with prompting
- produce tailored, context-aware feedback in real time

This makes it a useful example of an **agentic AI workflow** built with `n8n`.
