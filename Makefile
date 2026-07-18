all: README.md result.csv result6.csv

README.md: table.md table6.md topas-history.svg topas-history6.svg
	./produce-readme table.md table6.md < README.skel.md > README.md.tmp
	mv README.md.tmp README.md

.PHONY: clean

clean:
	rm -f \
		*.tmp \
		asmap \
		aslist \
		routelist \
		route6list \
		rpki-enabled \
		rpki6-enabled \
		table.md \
		table6.md \
		result.csv \
		result6.csv \
		README.md \
		topas \
		topas6 \
		topas-history \
		topas-history6 \
		topas-history.svg \
		topas-history6.svg

asmap:
	curl -sS 'https://krnic.kisa.or.kr/jsp/business/management/asList.jsp' | \
		./get-kisa-asmap > asmap.tmp
	mv asmap.tmp asmap

aslist: asmap
	grep -Eoi 'AS[0-9]+' asmap > aslist.tmp
	mv aslist.tmp aslist

routelist: aslist
	./query-prefixes < aslist 3< aslist > routelist.tmp
	mv routelist.tmp routelist
route6list: aslist
	./query-prefixes -6 < aslist 3< aslist > route6list.tmp
	mv route6list.tmp route6list

rpki-enabled: routelist
	./query-rpki-prefixes < routelist > rpki-enabled.tmp
	mv rpki-enabled.tmp rpki-enabled
rpki6-enabled: route6list
	./query-rpki-prefixes < route6list > rpki6-enabled.tmp
	mv rpki6-enabled.tmp rpki6-enabled

table.md: asmap routelist rpki-enabled
	./produce-table asmap routelist rpki-enabled > table.md.tmp
	mv table.md.tmp table.md
table6.md: asmap route6list rpki6-enabled
	./produce-table asmap route6list rpki6-enabled > table6.md.tmp
	mv table6.md.tmp table6.md

result.csv: asmap routelist rpki-enabled
	./produce-table -c asmap routelist rpki-enabled > result.csv.tmp
	mv result.csv.tmp result.csv
result6.csv: asmap route6list rpki6-enabled
	./produce-table -c asmap route6list rpki6-enabled > result6.csv.tmp
	mv result6.csv.tmp result6.csv

topas: asmap routelist rpki-enabled
	./produce-table -t asmap routelist rpki-enabled > topas.tmp
	mv topas.tmp topas
topas6: asmap route6list rpki6-enabled
	./produce-table -t asmap route6list rpki6-enabled > topas6.tmp
	mv topas6.tmp topas6

topas-history: result.csv topas
	./extract-as-history "topas" "result.csv" > topas-history.tmp
	mv topas-history.tmp topas-history
topas-history6: result6.csv topas6
	./extract-as-history "topas6" "result6.csv" > topas-history6.tmp
	mv topas-history6.tmp topas-history6

topas-history.svg: topas-history
	./plot-history < topas-history > topas-history.svg.tmp
	mv topas-history.svg.tmp topas-history.svg
topas-history6.svg: topas-history6
	./plot-history < topas-history6 > topas-history6.svg.tmp
	mv topas-history6.svg.tmp topas-history6.svg
