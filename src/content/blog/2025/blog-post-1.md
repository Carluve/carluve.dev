---
title: "Can AI Pass Spain’s Toughest Medical Exam?"
pubDatetime: 2025-04-19
description: "Can AI Pass Spain’s Toughest Medical Exam?"
tags: ['medical-education', 'ai-in-healthcare', 'mir', 'llms']
draft: false
---

The Spanish MIR (Médico Interno Residente) exam is one of the most rigorous medical licensing tests in Europe. It determines who gets into residency programs in Spain, and it's known for its complex clinical scenarios, image-based questions, and country-specific epidemiological knowledge. But what happens when you ask an AI to take the MIR?

That’s exactly what a group of researchers from the University of Alcalá and Binpar set out to explore. Their recent study compared the performance of 22 large language models (LLMs) — including GPT-4, Claude, Deepseek, and fine-tuned models like *Miri Pro* — on the MIR exams from 2024 and 2025.

And the results are... impressive. And a little unsettling.

## TL;DR: Some AIs Outperformed Humans

One of the standout performers was *Miri Pro*, a domain-specific model fine-tuned on Spanish medical content. It scored 195 out of 210 on the 2025 MIR — that's better than the top human candidate, who scored 186. Even general-purpose models like GPT-4 scored in the top 10% of human participants.

So yes, AI can pass the MIR. In some cases, it can even ace it.

## But Is It Real Understanding?

The real test wasn’t just about getting the answers right — it was about *how* the models got there. The MIR isn’t trivia night; it’s full of case-based questions, lab data interpretation, and image analysis.

To see whether the models were reasoning or just regurgitating memorized facts, the researchers modified two questions in the 2025 exam to prevent data leakage. The result? Fine-tuned models like *Miri Pro* handled them well, while general-purpose models struggled — a sign that real reasoning, not just memorization, is in play.

## Multimodal Power: Vision Models Shine

About 25 questions in each exam required analyzing images — think X-rays, histology slides, or ECGs. Unsurprisingly, models with visual capabilities like *Grok Vision Beta* and *Gemini Vision Pro* did significantly better on these.

For example, *Grok Vision Beta* scored 85.3% on image-based questions in 2025 — outperforming both humans and text-only models.

## So, Are Doctors Replaceable?

Not so fast. While these AI models can solve structured problems very well, they still lag behind humans in empathy, ethical judgment, and nuanced clinical reasoning.

For example, in scenarios involving end-of-life decisions or triage prioritization, even the best models scored 23–29% lower than their human counterparts. That’s a huge gap, and a reminder that medical care is more than just pattern recognition.

## What This Means for Medical Education

This paper suggests that the MIR — and exams like it — could become valuable benchmarks for testing AI’s reasoning skills. It also highlights the need to:

- **Update medical curricula** to include AI literacy.
- **Shift assessments** toward evaluating what AI still can’t do well (like ethical reasoning and communication).
- **Establish new certification standards** for AI use in clinical settings.

## Final Thoughts

This study is more than just a curiosity about what ChatGPT can do. It’s a glimpse into a future where AI doesn’t just support medical education — it changes it. Imagine AI tutors that adapt to your weaknesses, simulate clinical scenarios, and help prepare you for exams with personalized feedback.

But we have to proceed carefully. These models are powerful, but they still hallucinate, carry biases, and lack the human touch. The goal shouldn’t be to replace doctors — it’s to empower them.

Want to dive deeper into the technical details or see the full performance graphs? You can read the full paper [here](https://arxiv.org/abs/2503.00025).
