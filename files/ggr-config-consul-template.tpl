<qa:browsers xmlns:qa="urn:config.gridrouter.qatools.ru">
{{- range $browser, $nodes := service "selenoid" | byTag }}
    {{- range $nodes }}
        {{- $address := .Address }}{{ $port := .Port }}{{ $node := . }}
        {{- with (index .ServiceMeta $browser | split ",") }}
            {{- $list := . }}
            {{- range $i := loop (printf "%d" ( . | len) | parseInt) }}
                {{- $version := index $list $i }}
                {{- if not (scratch.MapValues $browser | contains $version) }}
                    {{- scratch.MapSetX $browser ($node.NodeID) $version }}
                    {{- scratch.MapSetX $version ($node.NodeID) (print $address ":" $port) }}
                {{- else }}
                    {{- scratch.MapSet $version ($node.NodeID) (print $address ":" $port) }}
                {{- end }}
            {{- end }}
        {{- end }}
    {{- end }}
    {{- with (scratch.MapValues $browser) }}
        {{- $versions_list := . }}
        {{- range $i := loop (printf "%d" ( $versions_list | len) | parseInt) }}
            {{- scratch.MapSet "defaultVersion" (index $versions_list $i) (index $versions_list $i) }}
        {{- end }}
    {{- if eq $browser "ie11" }}
    <browser name="internet explorer" defaultVersion="{{ index (scratch.MapValues "defaultVersion") ((printf "%d" ( $versions_list | len) | parseInt) | subtract 1) }}">
    {{- else }}
    <browser name="{{ $browser }}" defaultVersion="{{ index (scratch.MapValues "defaultVersion") ((printf "%d" ( $versions_list | len) | parseInt) | subtract 1) }}">
    {{- end }}
        {{- range $i := loop (printf "%d" ( $versions_list | len) | parseInt) }}
            {{- $version := (index $versions_list $i) }}
            {{- with (scratch.MapValues $version) }}
            <version number="{{ $version }}">
                <region name="1">
                {{- $nodes_list := . }}
                {{- range $k := loop (printf "%d" ( $nodes_list | len) | parseInt) }}
                    <host name="{{ index (index $nodes_list $k | split ":") 0 }}" port="{{ index (index $nodes_list $k | split ":") 1 }}" count="100"/>
                {{- end }}
                </region>
            </version>
            {{- end }}
        {{- end }}
    </browser>
    {{- end }}
{{- end }}
</qa:browsers>