#!/usr/bin/env bash
# Command completion for osc
# Generated by Clikt

__skip_opt_eq() {
    # this takes advantage of the fact that bash functions can write to local
    # variables in their callers
    (( i = i + 1 ))
    if [[ "${COMP_WORDS[$i]}" == '=' ]]; then
          (( i = i + 1 ))
    fi
}

__complete_files() {
   # Generate filename completions
   local word="$1"
   local IFS=$'\n'

   # quote each completion to support spaces and special characters
   COMPREPLY=($(compgen -o filenames -f -- "$word" | while read -r line; do
       printf "%q\n" "$line"
   done))
}

_osc() {
  local i=1
  local in_param=''
  local fixed_arg_names=()
  local vararg_name=''
  local can_parse_options=1

  while [[ ${i} -lt $COMP_CWORD ]]; do
    if [[ ${can_parse_options} -eq 1 ]]; then
      case "${COMP_WORDS[$i]}" in
        --)
          can_parse_options=0
          (( i = i + 1 ));
          continue
          ;;
        --version|-v)
          __skip_opt_eq
          in_param=''
          continue
          ;;
        --json)
          __skip_opt_eq
          in_param=''
          continue
          ;;
        -h|--help)
          __skip_opt_eq
          in_param=''
          continue
          ;;
      esac
    fi
    case "${COMP_WORDS[$i]}" in
      auth)
        _osc_auth $(( i + 1 ))
        return
        ;;
      runs)
        _osc_runs $(( i + 1 ))
        return
        ;;
      *)
        (( i = i + 1 ))
        # drop the head of the array
        fixed_arg_names=("${fixed_arg_names[@]:1}")
        ;;
    esac
  done
  local word="${COMP_WORDS[$COMP_CWORD]}"
  if [[ "${word}" =~ ^[-] ]]; then
    COMPREPLY=($(compgen -W '--version -v --json -h --help' -- "${word}"))
    return
  fi

  # We're either at an option's value, or the first remaining fixed size
  # arg, or the vararg if there are no fixed args left
  [[ -z "${in_param}" ]] && in_param=${fixed_arg_names[0]}
  [[ -z "${in_param}" ]] && in_param=${vararg_name}

  case "${in_param}" in
    "--version")
      ;;
    "--json")
      ;;
    "--help")
      ;;
    *)
      COMPREPLY=($(compgen -W 'auth runs' -- "${word}"))
      ;;
  esac
}

_osc_auth() {
  local i=$1
  local in_param=''
  local fixed_arg_names=()
  local vararg_name=''
  local can_parse_options=1

  while [[ ${i} -lt $COMP_CWORD ]]; do
    if [[ ${can_parse_options} -eq 1 ]]; then
      case "${COMP_WORDS[$i]}" in
        --)
          can_parse_options=0
          (( i = i + 1 ));
          continue
          ;;
        -h|--help)
          __skip_opt_eq
          in_param=''
          continue
          ;;
      esac
    fi
    case "${COMP_WORDS[$i]}" in
      login)
        _osc_auth_login $(( i + 1 ))
        return
        ;;
      logout)
        _osc_auth_logout $(( i + 1 ))
        return
        ;;
      *)
        (( i = i + 1 ))
        # drop the head of the array
        fixed_arg_names=("${fixed_arg_names[@]:1}")
        ;;
    esac
  done
  local word="${COMP_WORDS[$COMP_CWORD]}"
  if [[ "${word}" =~ ^[-] ]]; then
    COMPREPLY=($(compgen -W '-h --help' -- "${word}"))
    return
  fi

  # We're either at an option's value, or the first remaining fixed size
  # arg, or the vararg if there are no fixed args left
  [[ -z "${in_param}" ]] && in_param=${fixed_arg_names[0]}
  [[ -z "${in_param}" ]] && in_param=${vararg_name}

  case "${in_param}" in
    "--help")
      ;;
    *)
      COMPREPLY=($(compgen -W 'login logout' -- "${word}"))
      ;;
  esac
}

_osc_auth_login() {
  local i=$1
  local in_param=''
  local fixed_arg_names=()
  local vararg_name=''
  local can_parse_options=1

  while [[ ${i} -lt $COMP_CWORD ]]; do
    if [[ ${can_parse_options} -eq 1 ]]; then
      case "${COMP_WORDS[$i]}" in
        --)
          can_parse_options=0
          (( i = i + 1 ));
          continue
          ;;
        --url)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--url' || in_param=''
          continue
          ;;
        --token-url)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--token-url' || in_param=''
          continue
          ;;
        --client-id)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--client-id' || in_param=''
          continue
          ;;
        --username)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--username' || in_param=''
          continue
          ;;
        --password)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--password' || in_param=''
          continue
          ;;
        -h|--help)
          __skip_opt_eq
          in_param=''
          continue
          ;;
      esac
    fi
    case "${COMP_WORDS[$i]}" in
      *)
        (( i = i + 1 ))
        # drop the head of the array
        fixed_arg_names=("${fixed_arg_names[@]:1}")
        ;;
    esac
  done
  local word="${COMP_WORDS[$COMP_CWORD]}"
  if [[ "${word}" =~ ^[-] ]]; then
    COMPREPLY=($(compgen -W '--url --token-url --client-id --username --password -h --help' -- "${word}"))
    return
  fi

  # We're either at an option's value, or the first remaining fixed size
  # arg, or the vararg if there are no fixed args left
  [[ -z "${in_param}" ]] && in_param=${fixed_arg_names[0]}
  [[ -z "${in_param}" ]] && in_param=${vararg_name}

  case "${in_param}" in
    "--url")
      ;;
    "--token-url")
      ;;
    "--client-id")
      ;;
    "--username")
      ;;
    "--password")
      ;;
    "--help")
      ;;
  esac
}

_osc_auth_logout() {
  local i=$1
  local in_param=''
  local fixed_arg_names=()
  local vararg_name=''
  local can_parse_options=1

  while [[ ${i} -lt $COMP_CWORD ]]; do
    if [[ ${can_parse_options} -eq 1 ]]; then
      case "${COMP_WORDS[$i]}" in
        --)
          can_parse_options=0
          (( i = i + 1 ));
          continue
          ;;
        -h|--help)
          __skip_opt_eq
          in_param=''
          continue
          ;;
      esac
    fi
    case "${COMP_WORDS[$i]}" in
      *)
        (( i = i + 1 ))
        # drop the head of the array
        fixed_arg_names=("${fixed_arg_names[@]:1}")
        ;;
    esac
  done
  local word="${COMP_WORDS[$COMP_CWORD]}"
  if [[ "${word}" =~ ^[-] ]]; then
    COMPREPLY=($(compgen -W '-h --help' -- "${word}"))
    return
  fi

  # We're either at an option's value, or the first remaining fixed size
  # arg, or the vararg if there are no fixed args left
  [[ -z "${in_param}" ]] && in_param=${fixed_arg_names[0]}
  [[ -z "${in_param}" ]] && in_param=${vararg_name}

  case "${in_param}" in
    "--help")
      ;;
  esac
}

_osc_runs() {
  local i=$1
  local in_param=''
  local fixed_arg_names=()
  local vararg_name=''
  local can_parse_options=1

  while [[ ${i} -lt $COMP_CWORD ]]; do
    if [[ ${can_parse_options} -eq 1 ]]; then
      case "${COMP_WORDS[$i]}" in
        --)
          can_parse_options=0
          (( i = i + 1 ));
          continue
          ;;
        -h|--help)
          __skip_opt_eq
          in_param=''
          continue
          ;;
      esac
    fi
    case "${COMP_WORDS[$i]}" in
      download)
        _osc_runs_download $(( i + 1 ))
        return
        ;;
      info)
        _osc_runs_info $(( i + 1 ))
        return
        ;;
      start)
        _osc_runs_start $(( i + 1 ))
        return
        ;;
      *)
        (( i = i + 1 ))
        # drop the head of the array
        fixed_arg_names=("${fixed_arg_names[@]:1}")
        ;;
    esac
  done
  local word="${COMP_WORDS[$COMP_CWORD]}"
  if [[ "${word}" =~ ^[-] ]]; then
    COMPREPLY=($(compgen -W '-h --help' -- "${word}"))
    return
  fi

  # We're either at an option's value, or the first remaining fixed size
  # arg, or the vararg if there are no fixed args left
  [[ -z "${in_param}" ]] && in_param=${fixed_arg_names[0]}
  [[ -z "${in_param}" ]] && in_param=${vararg_name}

  case "${in_param}" in
    "--help")
      ;;
    *)
      COMPREPLY=($(compgen -W 'download info start' -- "${word}"))
      ;;
  esac
}

_osc_runs_download() {
  local i=$1
  local in_param=''
  local fixed_arg_names=()
  local vararg_name=''
  local can_parse_options=1

  while [[ ${i} -lt $COMP_CWORD ]]; do
    if [[ ${can_parse_options} -eq 1 ]]; then
      case "${COMP_WORDS[$i]}" in
        --)
          can_parse_options=0
          (( i = i + 1 ));
          continue
          ;;
        -h|--help)
          __skip_opt_eq
          in_param=''
          continue
          ;;
      esac
    fi
    case "${COMP_WORDS[$i]}" in
      logs)
        _osc_runs_download_logs $(( i + 1 ))
        return
        ;;
      reports)
        _osc_runs_download_reports $(( i + 1 ))
        return
        ;;
      *)
        (( i = i + 1 ))
        # drop the head of the array
        fixed_arg_names=("${fixed_arg_names[@]:1}")
        ;;
    esac
  done
  local word="${COMP_WORDS[$COMP_CWORD]}"
  if [[ "${word}" =~ ^[-] ]]; then
    COMPREPLY=($(compgen -W '-h --help' -- "${word}"))
    return
  fi

  # We're either at an option's value, or the first remaining fixed size
  # arg, or the vararg if there are no fixed args left
  [[ -z "${in_param}" ]] && in_param=${fixed_arg_names[0]}
  [[ -z "${in_param}" ]] && in_param=${vararg_name}

  case "${in_param}" in
    "--help")
      ;;
    *)
      COMPREPLY=($(compgen -W 'logs reports' -- "${word}"))
      ;;
  esac
}

_osc_runs_download_logs() {
  local i=$1
  local in_param=''
  local fixed_arg_names=()
  local vararg_name=''
  local can_parse_options=1

  while [[ ${i} -lt $COMP_CWORD ]]; do
    if [[ ${can_parse_options} -eq 1 ]]; then
      case "${COMP_WORDS[$i]}" in
        --)
          can_parse_options=0
          (( i = i + 1 ));
          continue
          ;;
        --run-id)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--run-id' || in_param=''
          continue
          ;;
        --repository-id)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--repository-id' || in_param=''
          continue
          ;;
        --index)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--index' || in_param=''
          continue
          ;;
        --output-dir|-o)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--output-dir' || in_param=''
          continue
          ;;
        --level)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--level' || in_param=''
          continue
          ;;
        --steps)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--steps' || in_param=''
          continue
          ;;
        -h|--help)
          __skip_opt_eq
          in_param=''
          continue
          ;;
      esac
    fi
    case "${COMP_WORDS[$i]}" in
      *)
        (( i = i + 1 ))
        # drop the head of the array
        fixed_arg_names=("${fixed_arg_names[@]:1}")
        ;;
    esac
  done
  local word="${COMP_WORDS[$COMP_CWORD]}"
  if [[ "${word}" =~ ^[-] ]]; then
    COMPREPLY=($(compgen -W '--run-id --repository-id --index --output-dir -o --level --steps -h --help' -- "${word}"))
    return
  fi

  # We're either at an option's value, or the first remaining fixed size
  # arg, or the vararg if there are no fixed args left
  [[ -z "${in_param}" ]] && in_param=${fixed_arg_names[0]}
  [[ -z "${in_param}" ]] && in_param=${vararg_name}

  case "${in_param}" in
    "--run-id")
      ;;
    "--repository-id")
      ;;
    "--index")
      ;;
    "--output-dir")
      ;;
    "--level")
      COMPREPLY=($(compgen -W 'DEBUG INFO WARN ERROR' -- "${word}"))
      ;;
    "--steps")
      COMPREPLY=($(compgen -W 'CONFIG ANALYZER ADVISOR SCANNER EVALUATOR REPORTER NOTIFIER' -- "${word}"))
      ;;
    "--help")
      ;;
  esac
}

_osc_runs_download_reports() {
  local i=$1
  local in_param=''
  local fixed_arg_names=()
  local vararg_name=''
  local can_parse_options=1

  while [[ ${i} -lt $COMP_CWORD ]]; do
    if [[ ${can_parse_options} -eq 1 ]]; then
      case "${COMP_WORDS[$i]}" in
        --)
          can_parse_options=0
          (( i = i + 1 ));
          continue
          ;;
        --run-id)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--run-id' || in_param=''
          continue
          ;;
        --repository-id)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--repository-id' || in_param=''
          continue
          ;;
        --index)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--index' || in_param=''
          continue
          ;;
        --file-names|--filenames)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--file-names' || in_param=''
          continue
          ;;
        --output-dir|-o)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--output-dir' || in_param=''
          continue
          ;;
        -h|--help)
          __skip_opt_eq
          in_param=''
          continue
          ;;
      esac
    fi
    case "${COMP_WORDS[$i]}" in
      *)
        (( i = i + 1 ))
        # drop the head of the array
        fixed_arg_names=("${fixed_arg_names[@]:1}")
        ;;
    esac
  done
  local word="${COMP_WORDS[$COMP_CWORD]}"
  if [[ "${word}" =~ ^[-] ]]; then
    COMPREPLY=($(compgen -W '--run-id --repository-id --index --file-names --filenames --output-dir -o -h --help' -- "${word}"))
    return
  fi

  # We're either at an option's value, or the first remaining fixed size
  # arg, or the vararg if there are no fixed args left
  [[ -z "${in_param}" ]] && in_param=${fixed_arg_names[0]}
  [[ -z "${in_param}" ]] && in_param=${vararg_name}

  case "${in_param}" in
    "--run-id")
      ;;
    "--repository-id")
      ;;
    "--index")
      ;;
    "--file-names")
      ;;
    "--output-dir")
      ;;
    "--help")
      ;;
  esac
}

_osc_runs_info() {
  local i=$1
  local in_param=''
  local fixed_arg_names=()
  local vararg_name=''
  local can_parse_options=1

  while [[ ${i} -lt $COMP_CWORD ]]; do
    if [[ ${can_parse_options} -eq 1 ]]; then
      case "${COMP_WORDS[$i]}" in
        --)
          can_parse_options=0
          (( i = i + 1 ));
          continue
          ;;
        --run-id)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--run-id' || in_param=''
          continue
          ;;
        --repository-id)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--repository-id' || in_param=''
          continue
          ;;
        --index)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--index' || in_param=''
          continue
          ;;
        -h|--help)
          __skip_opt_eq
          in_param=''
          continue
          ;;
      esac
    fi
    case "${COMP_WORDS[$i]}" in
      *)
        (( i = i + 1 ))
        # drop the head of the array
        fixed_arg_names=("${fixed_arg_names[@]:1}")
        ;;
    esac
  done
  local word="${COMP_WORDS[$COMP_CWORD]}"
  if [[ "${word}" =~ ^[-] ]]; then
    COMPREPLY=($(compgen -W '--run-id --repository-id --index -h --help' -- "${word}"))
    return
  fi

  # We're either at an option's value, or the first remaining fixed size
  # arg, or the vararg if there are no fixed args left
  [[ -z "${in_param}" ]] && in_param=${fixed_arg_names[0]}
  [[ -z "${in_param}" ]] && in_param=${vararg_name}

  case "${in_param}" in
    "--run-id")
      ;;
    "--repository-id")
      ;;
    "--index")
      ;;
    "--help")
      ;;
  esac
}

_osc_runs_start() {
  local i=$1
  local in_param=''
  local fixed_arg_names=()
  local vararg_name=''
  local can_parse_options=1

  while [[ ${i} -lt $COMP_CWORD ]]; do
    if [[ ${can_parse_options} -eq 1 ]]; then
      case "${COMP_WORDS[$i]}" in
        --)
          can_parse_options=0
          (( i = i + 1 ));
          continue
          ;;
        --repository-id)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--repository-id' || in_param=''
          continue
          ;;
        --wait)
          __skip_opt_eq
          in_param=''
          continue
          ;;
        --parameters-file)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--parameters-file' || in_param=''
          continue
          ;;
        --parameters)
          __skip_opt_eq
          (( i = i + 1 ))
          [[ ${i} -gt COMP_CWORD ]] && in_param='--parameters' || in_param=''
          continue
          ;;
        -h|--help)
          __skip_opt_eq
          in_param=''
          continue
          ;;
      esac
    fi
    case "${COMP_WORDS[$i]}" in
      *)
        (( i = i + 1 ))
        # drop the head of the array
        fixed_arg_names=("${fixed_arg_names[@]:1}")
        ;;
    esac
  done
  local word="${COMP_WORDS[$COMP_CWORD]}"
  if [[ "${word}" =~ ^[-] ]]; then
    COMPREPLY=($(compgen -W '--repository-id --wait --parameters-file --parameters -h --help' -- "${word}"))
    return
  fi

  # We're either at an option's value, or the first remaining fixed size
  # arg, or the vararg if there are no fixed args left
  [[ -z "${in_param}" ]] && in_param=${fixed_arg_names[0]}
  [[ -z "${in_param}" ]] && in_param=${vararg_name}

  case "${in_param}" in
    "--repository-id")
      ;;
    "--wait")
      ;;
    "--parameters-file")
      ;;
    "--parameters")
      ;;
    "--help")
      ;;
  esac
}

complete -F _osc osc
