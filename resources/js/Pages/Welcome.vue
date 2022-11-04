<template>
  <div class="container mx-auto">
    <div>
      <h1 class="py-5 font-bold text-xl">Users</h1>
    </div>
    <div class="overflow-x-auto relative">
      <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
        <tr>
          <th class="py-3 px-6" scope="col">
            First name
          </th>
          <th class="py-3 px-6" scope="col">
            Last name
          </th>
          <th class="py-3 px-6" scope="col">
            Email
        </th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="(user, index) in users" class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
        <th class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap dark:text-white" scope="row">
          {{ user.first_name }}
        </th>
        <td class="py-4 px-6">
          {{ user.last_name }}
        </td>
        <td class="py-4 px-6">
          {{ user.email }}
        </td>
      </tr>
      </tbody>
      </table>
    </div>
  </div>

</template>
<script setup>
const props = defineProps(['users'])

console.log(props.users)

</script>
