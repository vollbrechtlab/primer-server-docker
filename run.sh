target="/opt/primer-server/fa"

# docker run -it \
if [ -d "/lss/research/vollbrec-lab" ]
then
    source="/lss/research/vollbrec-lab/webapps/primer-server/fa"
else
    source="/media/data/lab_data/takao/primerDAFT/test/fa"
fi

docker run -it \
		-p 8001:80 \
		--mount type=bind,source=$source,target=$target \
		wkpalan/primer-server:v1