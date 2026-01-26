import type { APIRoute } from "astro";

export const GET: APIRoute = async () => {
  const markdownContent = `# Carlos Luengo (@carluve)

PhD Candidate, AI researcher, and technology consultant. Blog about AI, productivity, and real-world use cases.

## Navigation

- [About](/about.md)
- [Recent Posts](/posts.md)
- [Archives](/archives.md)
- [RSS Feed](/rss.xml)

## Links

- Twitter: [@carluve](https://twitter.com/carluve)
- GitHub: [@carluve](https://github.com/carluve)
- LinkedIn: [carlosluengo](https://linkedin.com/in/carlosluengo)
- Email: carluve@outlook.com

---

*This is the markdown-only version of carlosluengo.com. Visit [carlosluengo.com](https://carlosluengo.com) for the full experience.*`;

  return new Response(markdownContent, {
    status: 200,
    headers: {
      "Content-Type": "text/markdown; charset=utf-8",
      "Cache-Control": "public, max-age=3600",
    },
  });
};
