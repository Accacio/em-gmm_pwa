function plot_pwa(part,x,y)
  plot(x(x<part(2)),y(x<part(2)),'*')
  hold on
  for sidx=3:length(part)
    plot(x(x>=part(sidx-1)&x<part(sidx)),y(x>=part(sidx-1)&x<part(sidx)),'*')
  end
  hold off
end
