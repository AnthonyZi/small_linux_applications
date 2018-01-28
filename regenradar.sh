website="http://www.niederschlagsradar.de/image.ashx?type=regioloop&regio=ess&j=&m=&d=&mi=&uhr=&bliksem=0&voor=&srt=loop1stunde&tijdid=2016641323"

wget $website -O /home/zmann/Downloads/tmp/regenradar.gif &>/dev/null

gpicview /home/zmann/Downloads/tmp/regenradar.gif &
