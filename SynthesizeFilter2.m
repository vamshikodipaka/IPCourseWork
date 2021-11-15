
function OImg = SynthesizeFilter(h, w, pos)
OImg = ones([h w]);

x_min = pos(1);
y_min = pos(2);
w1 = pos(3);
h1 = pos(4);

OImg(y_min:y_min+h1, x_min:x_min+w1) = 0;

ym2 = h - pos(2) - h1+3;
OImg(ym2:ym2+h1, x_min:x_min+w1) = 0;

xm2 = w - pos(1) - w1+3;
OImg(y_min:y_min+h1, xm2:xm2+w1) = 0;
OImg(ym2:ym2+h1, xm2:xm2+w1) = 0;
end