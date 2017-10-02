
#!/bin/bash
#
# Gerador de CPF - ( bash Linux )
# by f0r34chb3t4 
#
# gerador_de_cpf.sh
# http://www.geradordecpf.net.br/
# http://www.macoratti.net/alg_cpf.htm
#
# CPF nº 000.000.00X-00
# 1. Tocantins, Mato Grosso do Sul, Goiás e Distrito Federal;
# 2. Roraima,Amapá, Amazonas, Acre, Rondônia e Pará;
# 3. Piauí, Maranhão e Ceará;
# 4. Rio Grande do Norte, Pernambuco, Alagoas e Paraíba;
# 5. Bahia e Sergipe;
# 6. Minas Gerais;
# 7. Rio de Janeiro e Espírito Santo;
# 8. São Paulo;
# 9. Paraná e Santa Catarina;
# 0. Rio Grande do Sul.
#
#

INT_A1=0
INT_A2=0
INT_A3=0
# -------
INT_B1=0
INT_B2=0
INT_B3=0
# -------
INT_C1=0
INT_C2=0
INT_C3=0
# -------
# -------
DIG_A1=0
DIG_A2=0
DIG_A3=0
# -------
DIG_B1=0
DIG_B2=0
DIG_B3=0
# -------
DIG_C1=0
DIG_C2=0
DIG_C3=0
# -------
DIG_D1=0
DIG_D2=0
# -------


# digito verificador 1 ( 000.000.000-X0 )
function verificador1(){
    local a=$(( $DIG_A1 * 10 ))
    local b=$(( $DIG_A2 * 9 ))
    local c=$(( $DIG_A3 * 8 ))
    local d=$(( $DIG_B1 * 7 ))
    local e=$(( $DIG_B2 * 6 ))
    local f=$(( $DIG_B3 * 5 ))
    local g=$(( $DIG_C1 * 4 ))
    local h=$(( $DIG_C2 * 3 ))
    local i=$(( $DIG_C3 * 2 ))
    local j=$(( $a + $b + $c + $d + $e + $f + $g + $h + $i ))
    local l=$(( $j % 11 ))
    [ $l -le 2 ] && DIG_D1=0 || DIG_D1=$(( 11 - $l ))
}


# digito verificador 2 ( 000.000.000-0X )
function verificador2(){
    local a=$(( $DIG_A1 * 11 ))
    local b=$(( $DIG_A2 * 10 ))
    local c=$(( $DIG_A3 * 9 ))
    local d=$(( $DIG_B1 * 8 ))
    local e=$(( $DIG_B2 * 7 ))
    local f=$(( $DIG_B3 * 6 ))
    local g=$(( $DIG_C1 * 5 ))
    local h=$(( $DIG_C2 * 4 ))
    local i=$(( $DIG_C3 * 3 ))
    local j=$(( $DIG_D1 * 2 ))
    local l=$(( $a + $b + $c + $d + $e + $f + $g + $h + $i + $j ))
    local m=$(( $l % 11 ))
    [ $m -le 2 ] && DIG_D2=0 || DIG_D2=$(( 11 - $m ))    
}


function validar(){
    local a1=$DIG_A1
    local a2=$DIG_A2
    local a3=$DIG_A3
    local b1=$DIG_B1
    local b2=$DIG_B2
    local b3=$DIG_B3
    local c1=$DIG_C1
    local c2=$DIG_C2
    local c3=$DIG_C3
    
    [[ "$a1$a2$a3$b1$b2$b3$c1$c2$c3" == '000000000' ]] && return 1
    [[ "$a1$a2$a3$b1$b2$b3$c1$c2$c3" == '111111111' ]] && return 1
    [[ "$a1$a2$a3$b1$b2$b3$c1$c2$c3" == '222222222' ]] && return 1
    [[ "$a1$a2$a3$b1$b2$b3$c1$c2$c3" == '333333333' ]] && return 1
    [[ "$a1$a2$a3$b1$b2$b3$c1$c2$c3" == '444444444' ]] && return 1
    [[ "$a1$a2$a3$b1$b2$b3$c1$c2$c3" == '555555555' ]] && return 1
    [[ "$a1$a2$a3$b1$b2$b3$c1$c2$c3" == '666666666' ]] && return 1
    [[ "$a1$a2$a3$b1$b2$b3$c1$c2$c3" == '777777777' ]] && return 1
    [[ "$a1$a2$a3$b1$b2$b3$c1$c2$c3" == '888888888' ]] && return 1
    [[ "$a1$a2$a3$b1$b2$b3$c1$c2$c3" == '999999999' ]] && return 1
    
    
    verificador1
    verificador2
    
    echo "${DIG_A1}${DIG_A2}${DIG_A3}${DIG_B1}${DIG_B2}${DIG_B3}${DIG_C1}${DIG_C2}${DIG_C3}${DIG_D1}${DIG_D2}" >> cpf-all.db
    
    return 0
}

# laco principal
for DIG_A1 in $( seq $INT_A1 9 ); do
    for DIG_A2 in $( seq $INT_A2 9 ); do
        for DIG_A3 in $( seq $INT_A3 9 ); do
            for DIG_B1 in $( seq $INT_B1 9 ); do
                for DIG_B2 in $( seq $INT_B2 9 ); do
                    for DIG_B3 in $( seq $INT_B3 9 ); do
                        for DIG_C1 in $( seq $INT_C1 9 ); do
                            for DIG_C2 in $( seq $INT_C2 9 ); do
                                for DIG_C3 in $( seq $INT_C3 9 ); do
                                    validar
                                done
                            done
                        done
                    done
                done
            done
        done
    done
done

exit 0
