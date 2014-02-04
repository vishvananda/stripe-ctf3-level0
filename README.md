Solution for stripe ctf-3 level0
================================

The perfect has was generated using a generic perfect hash generator in python:

http://ilan.schnell-web.net/prog/perfect-hash/

While the hash generation was significantly slower than mph:

http://www.ibiblio.org/pub/Linux/devel/lang/c/mph-1.2.tar.gz

the resulting hash was a bit faster.

I unrolled the hash function to calculate the hash as I walk through the buffer.

My testing showed that directly using syscall read/write to/from buffers had the best performance, and I/O seems to be the greatest limiting factor.

Note that this fails on a small percentage of the test input because it can't handle backslashes. Adding an additional check for valid characters would have slowed down the loop. Fortunately only about 1/1000 of the testing samples contained a backslash so the failure rate was minimal

The testing framework was extremely inconsistent. I saw scores between 1000 and 4000 for my final solution. I ran it a lot to have the best chance of getting a high score  and managed to get into a tie for 10th on the leaderboard:

https://stripe-ctf.com/leaderboard/0
