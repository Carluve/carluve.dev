---
title: "Meet FinanzSim: An Educational Financial Management Simulator"
pubDatetime: 2026-01-01T00:00:00Z
description: "Meet FinanzSim: My Educational Financial Management Simulator"
tags: ["finance", "education", "simulation", "project", "ai", "finanzsim", "edtech"]
draft: false
---

Meet FinanzSim: My Educational Financial Management Simulator

*An AI-powered web app I built to help business students master financial concepts through hands-on simulation.*

---

## What Is FinanzSim?

**FinanzSim** is an interactive web-based simulator designed specifically for first-year Business Studies students. The application allows learners to experience the complexities of managing a company's finances across multiple years, making strategic decisions and observing their real-time impact on key financial indicators.

Think of it as a sandbox where students can safely experiment with financial strategies, learn from their mistakes, and receive instant AI-generated feedback without any real-world consequences.

![Pantalla inicial de FinanzSim](/assets/img/2026/january/finanzsim2026_01.png)

---

## Objectives

I built FinanzSim with several clear goals in mind:

1. **Bridge Theory and Practice** — Transform abstract financial formulas into tangible, interactive experiences that students can explore hands-on.
2. **Develop Strategic Thinking** — Help students understand how decisions about pricing, costs, investments, and financing ripple through the entire financial structure of a business.
3. **Provide Instant Feedback** — Leverage AI to deliver personalised, real-time analysis after each simulated year, as if they had a virtual professor by their side.
4. **Demystify Financial Ratios** — Make complex metrics like ROA, ROE, liquidity ratios, and leverage accessible through visual dashboards and clear explanations.
5. **Encourage Experimentation** — Create a risk-free environment where making mistakes is part of the learning journey.

---

## How It Works

### Getting Started

1. **Choose Your Timeframe** — Select how many years you want to simulate (from 1 to 12 years).
2. **Start with Initial Capital** — Your company begins with a treasury of **100,000 €**.

![Selección de años y capital inicial](/assets/img/2026/january/finanzsim2026_02.png)

### Year-by-Year Management

For each simulated year, you'll make key business decisions:

| Decision | Description |
|----------|-------------|
| **Units Sold** | How many units of product you expect to sell |
| **Unit Price** | Your selling price per unit |
| **Variable Costs** | Cost per unit produced |
| **Fixed Costs** | Overheads that don't change with production volume |
| **New Investment** | Capital expenditure on assets |
| **New Loans** | Additional debt financing |
| **New Equity** | Fresh capital injection |
| **Collection Days** | How long customers take to pay you |
| **Payment Days** | How long you take to pay suppliers |

![Panel de decisiones anuales](/assets/img/2026/january/finanzsim2026_03.png)

### Real-Time Financial Analysis

After submitting your decisions for each year, FinanzSim calculates and displays:

- **Income Statement** — Revenue, EBIT, EBT, Net Income
- **Balance Sheet** — Assets, Liabilities, Equity
- **Break-Even Analysis** — How many units you need to sell to cover costs
- **Key Ratios** — ROA, ROE, Leverage, Liquidity, Solvency
- **Cash Flow** — For NPV calculations
- **Working Capital Cycle (PMM)** — Storage, manufacturing, sales, and collection periods

![Análisis financiero en tiempo real](/assets/img/2026/january/finanzsim2026_04.png)

### AI-Powered Professor Feedback

Here's where it gets interesting! After each year, an **AI professor** analyses your results and provides:

- Commentary on your financial performance
- Identification of potential risks
- Suggestions for improvement
- Comparison to typical business benchmarks

---

### Final Executive Report

Once you complete all simulation years, you can generate a **comprehensive executive report** that includes:

- Full performance analysis across all periods
- Net Present Value (NPV) of your company
- AI-generated strategic summary and recommendations
- Visual charts showing business evolution

---

## Tech Stack

I built FinanzSim using a modern, performant tech stack:

### Frontend
| Technology | Purpose |
|------------|---------|
| **React 19** | UI component library with hooks for state management |
| **TypeScript** | Type-safe development with enhanced IDE support |
| **Recharts** | Beautiful, responsive charts for data visualisation |
| **Vite** | Lightning-fast development server and build tool |

### Backend & AI
| Technology | Purpose |
|------------|---------|
| **Cloudflare Workers** | Serverless edge computing for the API |
| **Cloudflare Pages** | Global CDN deployment |
| **Google Gemini API** | AI-powered financial analysis and feedback generation |

### Deployment
| Technology | Purpose |
|------------|---------|
| **Wrangler** | Cloudflare's CLI for managing Workers and Pages |
| **Git** | Version control |

---

## About the Project

FinanzSim is a **research pet project** developed in collaboration with the *Faculty of Economics, Business and Tourism* at the **University of Alcalá (UAH)** in Spain.

The aim is to explore how AI-enhanced interactive simulations can improve financial literacy amongst university students, making complex concepts more approachable and engaging.

---

## Disclaimer

This application is an **educational simulator with no commercial purposes**. The AI-generated analyses are orientative and do not constitute professional financial advice. I am not responsible for misuse of the information, errors in AI responses, or service availability.

---

## Final Thoughts

Building FinanzSim has been an incredibly rewarding experience. Combining my passion for education technology with practical financial concepts has created something that I genuinely believe helps students learn.

If you're a student, educator, or just curious about business finances, I'd love to hear your feedback!